define [], ->

	main = ->
		svg = d3.select('body').append('svg')
		svg.g = svg.append('g')
		nodes = new D3Nodes svg.g
		nodes.join [ {n:1},{n:2} ]
		setTimeout (-> nodes.join [{n:3}]), 1000
			
	class D3Some
		constructor: (@parent) ->
			console.assert @select, "SomeD3 needs method 'select'!"
		join: (data) ->
			update = @select().data data
			@enter?  update.enter(), update
			@exit?   update.exit(), update
			@update? update

	class D3Nodes extends D3Some
		select: ->
			@parent.selectAll('g.node')
			
		enter: (enter, update) ->
			g = enter.append('g').classed('node', true)
			g.append('rect').attr(width: 30, height: 30)
			g.on 'mouseenter', @mouseenter
			g.on 'mouseout', @mouseout
			
		exit: (exit, update) ->
			exit.remove()
			
		update: (update) ->
			update.attr(transform: (d, i) -> "translate(#{10+i*40} #{100})")
			
		mouseenter: (d, i) ->
			label = d3.select(this).append('text')
			label.text(d.n).attr(x: 15, y: -30)
			this.label = label
			
		mouseout: (d, i) ->
			this.label?.remove()
				
	main()
