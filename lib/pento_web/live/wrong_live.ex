defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  @initial_number to_string(:rand.uniform(10))

  @initial_state %{
    score: 0,
    message: "Guess a number.",
    random: @initial_number,
    time: nil
  }

  def mount(_params, _session, socket) do
    {:ok, assign(socket, %{@initial_state | time: time()})}
  end

  def handle_event("guess", %{"number" => @initial_number}, socket) do
    message = "Whoohooo! You got it right 🥳"
    score = socket.assigns.score + 1

    {:noreply, assign(socket, message: message, score: score, time: time())}
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    message = "Your guess: #{guess}. Wrong. Guess again. "
    score = socket.assigns.score - 1

    {:noreply, assign(socket, message: message, score: score, time: time())}
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %> <br />
      It's <%= @time %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number={n}>
          <%= n %>
        </a>
      <% end %>
    </h2>
    """
  end

  def time() do
    DateTime.utc_now() |> to_string()
  end
end
