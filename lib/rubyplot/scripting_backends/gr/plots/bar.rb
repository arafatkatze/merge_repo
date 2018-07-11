module Rubyplot
  module Scripting
    module Plots
      class Bar < LazyBase
        def initialize(data, bar_color: :default, bar_width: :default,
                       bar_gap: :default, bar_edge: :default,
                       bar_edge_color: :default, bar_edge_width: :default)
          super()
          @tasks = []
          @bar_color = :easy_blue if bar_color == :default
          @bar_gap = 0 if bar_gap == :default
          @bar_width = 1 if bar_width == :default
          @bar_edge = true if bar_edge == :default
          @bar_edge_color = :black if bar_edge_color == :default
          @bar_edge_width = 0.02 if bar_edge_width == :default
          @data = data
          # All this will be repurposed
        end

        def call(state)
          # for Laazy plots the state has been passed  in the plotspace call
          # every lazy plot will have a call function rather than inherting it
          # tasks wont be pushed, rather they will be instantiated and called directly
          (0..@data.size - 1).to_a.each do |i|
            if @bar_edge
              SetFillColorIndex.new(GR_COLOR_INDEX[@bar_edge_color]).call
              SetFillInteriorStyle.new(GR_FILL_INTERIOR_STYLES[:solid]).call
              FillRectangle.new(i * (@bar_width + @bar_gap) - @bar_edge_width,
                           i * (@bar_width + @bar_gap) + @bar_width + @bar_edge_width,
                           state.y_range[0] - state.y_axis_padding, @data[i] + @bar_edge_width).call
            end

            SetFillColorIndex.new(GR_COLOR_INDEX[@bar_color]).call
            SetFillInteriorStyle.new(GR_FILL_INTERIOR_STYLES[:solid]).call
            FillRectangle.new(i * (@bar_width + @bar_gap),
                         i * (@bar_width + @bar_gap) + @bar_width,
                         state.y_range[0] - state.y_axis_padding, @data[i]).call
          end
        end
      end
    end
  end
end
