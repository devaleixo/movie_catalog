import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "aiSearchInput",
    "fetchButton",
    "buttonText",
    "buttonSpinner",
    "aiMessage",
    "titleField",
    "synopsisField",
    "releaseYearField",
    "durationField",
    "directorField",
    "ratingField"
  ]

  connect() {
    console.log("✅ Movie form controller connected successfully!")
    console.log("Available targets:", this.constructor.targets)
  }

  handleKeypress(event) {
    console.log("Key pressed:", event.key)
    if (event.key === "Enter") {
      event.preventDefault()
      this.fetchAiData()
    }
  }

  async fetchAiData() {
    console.log("🚀 fetchAiData() called")
    const movieTitle = this.aiSearchInputTarget.value.trim()
    console.log("Movie title:", movieTitle)

    if (!movieTitle) {
      console.log("⚠️ No movie title provided")
      this.showMessage("Por favor, digite o nome de um filme.", "warning")
      return
    }

    this.setLoading(true)
    this.clearMessage()
    console.log("📡 Sending request to server...")

    try {
      const response = await fetch("/movies/fetch_ai_data", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": this.getCSRFToken()
        },
        body: JSON.stringify({ title: movieTitle })
      })

      console.log("📥 Response received:", response.status)
      const data = await response.json()
      console.log("📄 Response data:", data)

      if (response.ok) {
        console.log("✅ Success! Filling form with data...")
        this.fillFormWithData(data)
        this.showMessage("✅ Dados preenchidos com sucesso!", "success")
      } else {
        console.log("❌ Error response:", data)
        this.showMessage(`❌ ${data.error || "Erro ao buscar dados"}`, "danger")
      }
    } catch (error) {
      console.error("❌ Error fetching AI data:", error)
      this.showMessage("❌ Erro ao conectar com o servidor", "danger")
    } finally {
      console.log("🏁 Request completed")
      this.setLoading(false)
    }
  }

  fillFormWithData(data) {
    if (data.title) this.titleFieldTarget.value = data.title
    if (data.synopsis) this.synopsisFieldTarget.value = data.synopsis
    if (data.release_year) this.releaseYearFieldTarget.value = data.release_year
    if (data.duration) this.durationFieldTarget.value = data.duration
    if (data.director) this.directorFieldTarget.value = data.director
    if (data.rating) this.ratingFieldTarget.value = data.rating

    // Marcar categorias se existirem
    if (data.categories && data.categories.length > 0) {
      this.selectCategories(data.categories)
    }
  }

  selectCategories(categories) {
    // Encontrar todos os checkboxes de categoria (não os campos hidden)
    const categoryCheckboxes = this.element.querySelectorAll('input[type="checkbox"][name="movie[category_ids][]"]')
    
    categoryCheckboxes.forEach(checkbox => {
      const formCheck = checkbox.closest('.form-check')
      if (formCheck) {
        const label = formCheck.querySelector('label')
        if (label) {
          const categoryName = label.textContent.trim()
          // Marcar se a categoria está na lista retornada pela IA
          checkbox.checked = categories.some(cat => 
            cat.toLowerCase() === categoryName.toLowerCase()
          )
        }
      }
    })
  }

  setLoading(loading) {
    if (loading) {
      this.fetchButtonTarget.disabled = true
      this.buttonTextTarget.classList.add("d-none")
      this.buttonSpinnerTarget.classList.remove("d-none")
    } else {
      this.fetchButtonTarget.disabled = false
      this.buttonTextTarget.classList.remove("d-none")
      this.buttonSpinnerTarget.classList.add("d-none")
    }
  }

  showMessage(message, type) {
    this.aiMessageTarget.innerHTML = `
      <div class="alert alert-${type} alert-dismissible fade show" role="alert">
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    `
  }

  clearMessage() {
    this.aiMessageTarget.innerHTML = ""
  }

  getCSRFToken() {
    const token = document.querySelector('meta[name="csrf-token"]')
    const tokenValue = token ? token.content : ""
    console.log("🔑 CSRF Token:", tokenValue ? "Found" : "NOT FOUND")
    return tokenValue
  }
}
