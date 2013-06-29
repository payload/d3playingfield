define [], ->

	main = ->
		svg = d3.select('body').append('svg')
		svg.g = svg.append('g')
		
		my_data = [ {n:1},{n:2} ]
		
		node = svg.g.selectAll('g.node').data(my_data)
		node.g = node.enter().append('g')
		node.g.append('rect').attr(width: 30, height: 30)
		node.exit().remove()
		node.attr(transform: (d, i) -> "translate(#{10+i*40} #{100})")
		
		node.on 'mouseenter', (d, i) ->
			label = d3.select(this).append('text')
			label.text(d.n).attr(x: 15, y: -30)
			this.label = label
			
		node.on 'mouseout', (d, i) ->
			this.label?.remove()
		
	main()
