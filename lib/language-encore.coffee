LanguageEncoreView = require './language-encore-view'
{CompositeDisposable} = require 'atom'

module.exports = LanguageEncore =
  languageEncoreView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @languageEncoreView = new LanguageEncoreView(state.languageEncoreViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @languageEncoreView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'language-encore:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @languageEncoreView.destroy()

  serialize: ->
    languageEncoreViewState: @languageEncoreView.serialize()

  toggle: ->
    console.log 'LanguageEncore was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
