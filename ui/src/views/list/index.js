import { format } from "date-fns"

class PhoneList {
    constructor(parentNode) {
        this.parentNode = parentNode
        this.selectedRowData = null
        this.phoneList = []
        this.getUser().then((data) => {
            this.render().then(() => {
                this.elemForm = document.querySelector('.editor')
                this.elemBlur = document.querySelector('.blur')
                this.bindEvents()
                this.setButtonStates()
                this.setUIState()
                this.refresh()
            })
        }).catch((e) => {
            alert(e)
        })
    }
getUser() {
        if (window.authService) {
            return window.authService.fetchUser()
        } else {
            return Promise.reject('Auth service is not ready')
        }
    }
    bindEvents() {
        const elemButtonAdd = document.querySelector('.phone-list__button-add')
        const elemButtonEdit = document.querySelector('.phone-list__button-edit')
        const elemButtonDownload = document.querySelector('.phone-list__button-download')
        const elemButtonSave = document.querySelector('.phone-editor__save')
        const elemButtonCancel = document.querySelector('.phone-editor__cancel')
        const elemButtonClose = document.querySelector('.phone-editor__close')
        const elemDownloadItems = document.querySelectorAll('.phone-list__popup li')

        if (elemButtonAdd) {
            elemButtonAdd.addEventListener('click', (e) => { this.handleAddClick(e) })
        }
        if (elemButtonEdit) {
            elemButtonEdit.addEventListener('click', (e) => { this.handleEditClick(e) })
        }
        if (elemButtonSave) {
            elemButtonSave.addEventListener('click', (e) => { this.handleSaveClick(e) })
        }
        if (elemButtonCancel) {
            elemButtonCancel.addEventListener('click', (e) => { this.handleClose(e) })
        }
        if (elemButtonClose) {
            elemButtonClose.addEventListener('click', (e) => { this.handleClose(e) })
        }
        if (elemButtonDownload) {
            elemButtonDownload.addEventListener('click', (e) => { this.handleOpenDownloadPopup(e) })
        }
        if (elemDownloadItems) {
            elemDownloadItems.forEach(x => {
                x.addEventListener('click', (e) => {
                    this.handleDownloadClick(e)
                })
            })
        }
    }
    openEditor() {
            if (this.elemBlur) {
                this.elemBlur.style.visibility = 'visible'
            }
            if (this.elemForm) {
                this.elemForm.style.visibility = 'visible'
            }
        }
        closeEditor() {
            if (this.elemBlur) {
                this.elemBlur.style.visibility = 'hidden'
            }
            if (this.elemForm) {
                this.elemForm.style.visibility = 'hidden'
            }
        }
        handleAddClick(e) {
            this.selectedRowData = null
            this.setButtonStates()
            this.openEditor()
        }
        handleEditClick(e) {
            this.fillEditorFields()
            this.openEditor()
        }
        handleSaveClick(e) {
            if (!this.checkRequiredFields()) {
                alert('Заполните все обязательные поля')
                return
            }
            this.save().then((res) => {
                if (res) {
                    this.handleClose()
                    this.refresh()
                }
            })
        }
        handleClose() {
            this.resetRequired()
            this.clearFields()
            this.closeEditor()
        }
        hideDownloadPopup() {
                const elemPopup = document.querySelector('.phone-list__popup')
                const elemBlocked = document.querySelector('.blocked')
                if (elemBlocked) {
                    elemBlocked.removeEventListener('click', this.hideDownloadPopup)
                    elemBlocked.classList.add('hidden')
                }
                if (elemPopup) {
                    elemPopup.classList.add('hidden')
                }
            }
            handleOpenDownloadPopup() {
                const elemBlocked = document.querySelector('.blocked')
                const elemPopup = document.querySelector('.phone-list__popup')
                if (elemBlocked) {
                    elemBlocked.classList.remove('hidden')
                    elemBlocked.addEventListener('click', this.hideDownloadPopup)
                }
                if (elemPopup) {
                    elemPopup.classList.remove('hidden')
                }
            }
            handleDownloadClick(e) {
                if (e?.target?.dataset?.format) {
                    this.downloadReport(e.target.dataset.format)
                    this.hideDownloadPopup()
                }
            }
            downloadReport(format = 'xlsx') {
                const url = `${import.meta.env.VITE_API_URL}/report?format=${format}`
                const a = document.createElement('a')
                a.href = url
                a.download = url.split('/').pop()
                document.body.appendChild(a)
                a.click()
                document.body.removeChild(a)
            }