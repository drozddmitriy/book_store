module CheckoutHelper
  def step_state(current_step)
    return 'active' if step_active?(current_step)

    'done' if past_step?(current_step)
  end

  def step_active?(current_step)
    current_step == step
  end
end
