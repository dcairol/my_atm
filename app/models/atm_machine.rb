class AtmMachine < ActiveRecord::Base

  attr_accessor :being_used

  def initialize
    @being_used = false
  end

  def start_using
    if being_used?
      ask_to_finish
    else
      show_welcome_message
    end
  end

  def finish_using
    @being_used = false
    "Goodbye!"
  end

  private
  def ask_to_finish
    "Please finish your current transaction before starting a new one."
  end

  def show_welcome_message
    @being_used = true
    "Welcome! Please enter your credentials."
  end

  def being_used?
    @being_used
  end

end