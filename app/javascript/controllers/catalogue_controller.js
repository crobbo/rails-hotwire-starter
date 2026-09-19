import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "tagStatus",
    "toast",
    "toastTemplate",
    "animation",
    "animationName",
    "animationStatus",
    "pageFrame",
    "pageDesktopButton",
    "pageMobileButton",
    "pageStatus",
    "randomContent",
    "randomStatus",
    "intersectionStatus",
    "resizeBox",
    "resizeStatus",
    "mutationBox",
    "mutationStatus"
  ]

  connect() {
    if (this.hasPageFrameTarget && window.matchMedia("(max-width: 47.999rem)").matches) {
      this.showMobilePage()
    }
  }

  removeTag(event) {
    event.currentTarget.remove()
    this.tagStatusTarget.textContent = "Rails tag removed."
  }

  showToast() {
    this.toastTarget.append(this.toastTemplateTarget.content.cloneNode(true))
  }

  playAnimation() {
    if (this.animationTarget.currentTime >= this.animationTarget.duration) {
      this.animationTarget.currentTime = 0
    }

    this.animationTarget.play = true
  }

  pauseAnimation() {
    this.animationTarget.play = false
    this.animationStatusTarget.textContent = "Animation paused."
  }

  restartAnimation() {
    this.animationTarget.cancel()
    requestAnimationFrame(() => {
      this.animationTarget.currentTime = 0
      this.animationTarget.play = true
    })
  }

  changeAnimation() {
    this.animationTarget.name = this.animationNameTarget.value
    requestAnimationFrame(() => {
      this.animationTarget.currentTime = 0
      this.animationTarget.play = true
    })
  }

  animationStarted() {
    this.animationStatusTarget.textContent = `${this.animationLabel()} animation playing.`
  }

  animationFinished() {
    this.animationStatusTarget.textContent = `${this.animationLabel()} animation finished.`
  }

  animationCanceled() {
    this.animationStatusTarget.textContent = "Animation reset."
  }

  showDesktopPage() {
    this.pageFrameTarget.classList.remove("catalogue-page-preview--mobile")
    this.updatePageButtons(true)
    this.pageStatusTarget.textContent = "Desktop page shell."
  }

  showMobilePage() {
    this.pageFrameTarget.classList.add("catalogue-page-preview--mobile")
    this.updatePageButtons(false)
    this.pageStatusTarget.textContent = "Mobile page shell. Use the menu button inside the preview to open navigation."
  }

  randomize() {
    const selection = this.randomContentTarget.randomize()
    const message = selection.map((element) => element.textContent.trim()).join(" ")

    this.randomStatusTarget.textContent = `Showing: ${message}`
  }

  intersectionChanged(event) {
    this.intersectionStatusTarget.textContent = event.detail.entry.isIntersecting ? "Element is in view." : "Element left the viewport."
  }

  resize() {
    this.resizeBoxTarget.classList.toggle("catalogue-utility-box--compact")
  }

  resized(event) {
    const width = Math.round(event.detail.entries[0].contentRect.width)
    this.resizeStatusTarget.textContent = `Observed width: ${width}px.`
  }

  mutate() {
    const updated = this.mutationBoxTarget.dataset.state !== "updated"

    this.mutationBoxTarget.dataset.state = updated ? "updated" : "ready"
    this.mutationBoxTarget.textContent = updated ? "The observed content changed." : "Ready for a DOM change."
  }

  mutated(event) {
    const count = event.detail.mutationList.length
    this.mutationStatusTarget.textContent = `Observed ${count} DOM ${count === 1 ? "change" : "changes"}.`
  }

  animationLabel() {
    return this.animationNameTarget.value.replace(/([A-Z])/g, " $1").replace(/^./, (letter) => letter.toUpperCase())
  }

  updatePageButtons(desktop) {
    this.pageDesktopButtonTarget.setAttribute("aria-pressed", desktop.toString())
    this.pageDesktopButtonTarget.appearance = desktop ? "filled" : "outlined"
    this.pageMobileButtonTarget.setAttribute("aria-pressed", (!desktop).toString())
    this.pageMobileButtonTarget.appearance = desktop ? "outlined" : "filled"
  }
}
