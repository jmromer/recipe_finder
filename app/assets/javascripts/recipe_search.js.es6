const queryForRecipes = (params, $resultsContainer) => {
  $.get(`/recipes?${params}`, (responseHtml) => {
    $resultsContainer.html(responseHtml)
  })
}

$(() => {
  const $form = $(".js-search-form").first()
  const $resultsContainer = $(".js-search-results").first()

  $form.on("submit", (event) => {
    event.preventDefault()
    const queryParams = $(event.target).serialize()
    queryForRecipes(queryParams, $resultsContainer)
  })

  $resultsContainer.on("click", ".js-search-link", (event) => {
    event.preventDefault()
    const searchTerm = $(event.target).text()
    $form.find("input").val(searchTerm)
    $(document).scrollTop(0)
    queryForRecipes(`ingredients=${searchTerm}`, $resultsContainer)
  })
})
