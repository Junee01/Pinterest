# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#This is Javascript scripts for loading masonry.
$ ->
  $('#pins').imagesLoaded ->
    $('#pins').masonry
      itemSelector: '.box'
      isFitWidth: true

#This is jQuery function for infinite scrolling.
jQuery ->
	if $('.pagination').length
		$(window).scroll ->
			url = $('.pagination .next_page').attr('href')
			if url && $(window).scrollTop() > $(document).height() - $(window).height() - 40
				$('.pagination').text("조금만 기다려봐 =ㅅ=...")
				$.getScript(url)
		$(window).scroll()