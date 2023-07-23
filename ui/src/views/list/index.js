import { format } from "date-fns"
import { ROLE_ADD, ROLE_DOWNLOAD, ROLE_EDIT, ROLE_VIEW } from '../../api/auth-service'

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
             handleRowClick(index) {
                    this.selectedRowData = null
                    const selectedId = parseInt(this.tableRows[index].id.replace('row', ''))
                    if (selectedId) {
                        this.selectedRowData = this.phoneList.find(x => (Number)(x.id) === selectedId)
                    }
                    this.tableRows.forEach(x => x.classList.remove('selected'))
                    this.tableRows[index].classList.add('selected')
                    this.setButtonStates()
                }
                setUIState() {
                    const table = document.querySelector('.phone-list__table')
                    const noAccess = document.querySelector('.phone-list__no-view-access')
                    if (noAccess) {
                        if (authService.checkPermission(ROLE_VIEW)) {
                            noAccess.classList.add('hidden')
                        } else {
                            noAccess.classList.remove('hidden')
                        }
                    }
                    if (table) {
                        if (authService.checkPermission(ROLE_VIEW)) {
                            table.classList.remove('hidden')
                        } else {
                            table.classList.add('hidden')
                        }
                    }
                }
                setButtonStates() {
                    const buttonEdit = document.querySelector('.phone-list__button-edit')
                    const buttonAdd = document.querySelector('.phone-list__button-add')
                    const buttonDownload = document.querySelector('.phone-list__button-download')
                    if (buttonEdit) {
                        buttonEdit.hidden = true;
                        if (this.selectedRowData && authService.checkPermission(ROLE_EDIT)) {
                            buttonEdit.hidden = false;
                        }
                    }
                    if (buttonAdd) {
                        if (authService.checkPermission(ROLE_ADD)) {
                            buttonAdd.hidden = false;
                        } else {
                            buttonAdd.hidden = true;
                        }
                    }
                    if (buttonDownload) {
                        if (authService.checkPermission(ROLE_DOWNLOAD)) {
                            buttonDownload.hidden = false;
                        } else {
                            buttonDownload.hidden = true;
                        }
                    }
                }
                async render() {
                    try {
                        const response = await fetch('./src/views/list/index.html')
                        const rowTemplateResponse = await fetch('./src/views/list/rowTemplate.html')
                        if (response) {
                            const htm = await response.text()
                            if (htm) {
                                this.parentNode.innerHTML = htm
                            }
                        }
                        if (rowTemplateResponse) {
                            this.rowTemplate = await (await rowTemplateResponse.text()).split('</script>')[1]
                        }
                    } catch(e) {
                        console.log(e)
                        alert('Ошибка рендера списка сотрудников')
                    }
                }
                getInputElements() {
                    return document.querySelectorAll('.phone-editor input, .phone-editor select')
                }
                async save() {
                    const data = {}
                    const elemInputs = this.getInputElements()
                    if (elemInputs) {
                        elemInputs.forEach(x => {
                            data[x.classList[0].replace('phone-editor__', '')] = x.value || ''
                        })
                    }
                    if (window.phoneServices) {
                        const response = this.selectedRowData ? await window.phoneServices.edit(this.selectedRowData.id, data) : await window.phoneServices.add(data)
                        if (response) {
                            return true
                        } else {
                            alert('Ошибка сохранения данных')
                        }
                    }
                    return false
                }
                async refresh() {
                    this.selectedRowData = null
                    this.setButtonStates()
                    if (!authService.checkPermission(ROLE_VIEW)) {
                        this.phoneList = []
                        return
                    }
                    if (window.phoneServices) {
                        this.phoneList = await window.phoneServices.getCatalog()
                        const tableElem = document.getElementById('tableBody')
                        let innerHtm = ''
                        if (tableElem) {
                            this.phoneList.forEach(row => {
                                innerHtm += this.generateRow(row)
                            })
                            tableElem.innerHTML = innerHtm
                        }
                        this.tableRows = tableElem.querySelectorAll('tr')
                        for (let i = 0; i < this.tableRows.length; i++) {
                            this.tableRows[i].addEventListener('click', (e) => {
                                this.handleRowClick(i)
                            })
                        }
                    }
                }
                generateRow(rowData) {
                    let htmRow = this.rowTemplate
                    if (rowData) {
                        for (const key in rowData) {
                            let value = ''
                            if (key.indexOf('date') >= 0 && rowData[key]) {
                                value = format(new Date(rowData[key]), 'dd.MM.yyyy')
                            } else {
                                value = rowData[key] || ''
                            }
                            htmRow = htmRow.replaceAll(`%${key}%`, value)
                        }
                    }
                    return htmRow
                }
                resetRequired() {
                    const elemInputs = this.getInputElements()
                    if (elemInputs) {
                        elemInputs.forEach(x => {
                            x.classList.remove('error')
                        })
                    }
                }
                clearFields() {
                    const elemInputs = this.getInputElements()
                    if (elemInputs) {
                        elemInputs.forEach(x => {
                            x.value = ''
                        })
                    }
                }
                checkRequiredFields() {
                    this.resetRequired()
                    const elemInputs = this.getInputElements()
                    let hasError = false
                    if (elemInputs) {
                        elemInputs.forEach(x => {
                            if (x.hasAttribute('required') && !x.value) {
                                hasError = true
                                x.classList.add('error')
                            }

                        })
                    }
                    return !hasError
                }
                fillEditorFields() {
                    if (this.selectedRowData) {
                        for (const key in this.selectedRowData) {
                            const elem = document.querySelector(`.phone-editor__${key}`)
                            if (elem) {
                                if (key.indexOf('date') >= 0 && this.selectedRowData[key]) {
                                    elem.value = format(new Date(this.selectedRowData[key]), 'yyyy-MM-dd')
                                } else {
                                    elem.value = this.selectedRowData[key] || ''
                                }
                            }
                        }
                    }
                }
            }

            export default PhoneList