module CryptoStat
  class ChartDrawer
    def build_canvas(parent_frame)
      require 'tk'
      TkCanvas.new(parent_frame) do
        width 380
        height 150
        background 'white'
        pack(pady: 10)
      end
    end

    def draw(canvas, prices)
      raise ArgumentError, "Массив цен пуст" if prices.empty?

      month_prices = prices.last(30)
      return if month_prices.length < 2

      canvas.delete('all')

      min_p = month_prices.min
      max_p = month_prices.max
      step_x = 380.0 / month_prices.length

      points = []
      month_prices.each_with_index do |price, index|
        x = index * step_x

        y = if max_p == min_p
              75
            else
              150 - ((price - min_p) / (max_p - min_p) * 150 * 0.8) - 10
            end

        points << x
        points << y
      end

      require 'tk'
      TkcLine.new(canvas, points, fill: 'blue', width: 2)
    end

    def get_month_prices(prices)
      raise ArgumentError, "Массив цен пуст" if prices.empty?
      prices.last(30)
    end
  end
end
