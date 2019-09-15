class HealthBar

  DRAIN_COUNTER = 100
  BAR_THICKNESS = 5
  ORIGIN = [150, 650]

  def initialize(width, height, fill_pct)
    @width = width
    @height = height
    @fill_pct = fill_pct
    @drain_speed = 1
    @drain_counter = DRAIN_COUNTER
  end

  def drain
    @drain_counter -= @drain_speed
    if @drain_counter <= 0
      @fill_pct -= 1
      @drain_counter = DRAIN_COUNTER
    end
  end

  def render(outputs)
    # compute point delimiting empty and full
    pct = [0.0, [1.0, (100 - @fill_pct) / 100].min].max
    bar_empty_limit = (@width - 2 * BAR_THICKNESS) * pct

    outputs.solids << [ORIGIN,
                       @width,
                       @height,
                       [0, 240, 0]]
    outputs.solids << [ORIGIN[0] + BAR_THICKNESS,
                       ORIGIN[1] + BAR_THICKNESS,
                       bar_empty_limit,
                       @height - 2 * BAR_THICKNESS,
                       [0, 0, 0]]
    outputs.solids << [ORIGIN[0] + BAR_THICKNESS + bar_empty_limit,
                       ORIGIN[1] + BAR_THICKNESS,
                       @width - 2 * BAR_THICKNESS - bar_empty_limit,
                       @height - 2 * BAR_THICKNESS,
                       [255, 0, 0]]
  end

  def tick(outputs)
    drain
    render(outputs)
  end
end
