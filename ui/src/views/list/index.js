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