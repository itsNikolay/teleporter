class BootstrapInit
  constructor: ->
    $("a[rel=popover], .popover").popover()
    $("a[rel=tooltip], .tooltip").tooltip()
    $('.dropdown-toggle').dropdown()

$ -> new BootstrapInit
