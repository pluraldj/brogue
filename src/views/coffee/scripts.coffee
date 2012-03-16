(($) ->
  $("a[data-id]").live "click", (e) ->
    e.preventDefault()
    modalLocation = $(this).attr("data-id")
    $("#" + modalLocation).reveal $(this).data()

  $.fn.reveal = (options) ->
    defaults =
      animation: "fade"
      animationspeed: 300
      closeonbackgroundclick: true
      dismissmodalclass: "close-modal"

    options = $.extend({}, defaults, options)
    @each ->
      unlockModal = ->
        locked = false
      lockModal = ->
        locked = true
      modal = $(this)
      topMeasure = parseInt(modal.css("top"))
      topOffset = modal.height() + topMeasure
      locked = false
      modalBG = $(".modal-bg")
      modalBG = $("<div class=\"modal-bg\" />").insertAfter(modal)  if modalBG.length is 0
      modal.bind "reveal:open", ->
        modalBG.unbind "click.modalEvent"
        $("." + options.dismissmodalclass).unbind "click.modalEvent"
        unless locked
          lockModal()
          if options.animation is "fade"
            modal.css
              opacity: 0
              visibility: "visible"
              top: $(document).scrollTop() + topMeasure

            modalBG.fadeIn options.animationspeed / 2
            modal.delay(options.animationspeed / 2).animate
              opacity: 1
            , options.animationspeed, unlockModal()
        modal.unbind "reveal:open"

      modal.bind "reveal:close", ->
        unless locked
          lockModal()
          if options.animation is "fade"
            modalBG.delay(options.animationspeed).fadeOut options.animationspeed
            modal.animate
              opacity: 0
            , options.animationspeed, ->
              modal.css
                opacity: 1
                visibility: "hidden"
                top: topMeasure

              unlockModal()
        modal.unbind "reveal:close"

      modal.trigger "reveal:open"
      closeButton = $("." + options.dismissmodalclass).bind("click.modalEvent", ->
        modal.trigger "reveal:close"
      )
      if options.closeonbackgroundclick
        modalBG.css cursor: "pointer"
        modalBG.bind "click.modalEvent", ->
          modal.trigger "reveal:close"
      $("body").keyup (e) ->
        modal.trigger "reveal:close"  if e.which is 27
) jQuery