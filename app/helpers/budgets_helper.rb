module BudgetsHelper
	def format_budget_datetime(budget)
		"#{budget.event_date.strftime('%d/%m/%y')} às #{budget.start_time.strftime('%H:%M')}"
	end

	def render_budget_icon(budget)
		icon = case budget.status
		when "PENDENTE"   then "clock.svg"
		when "CANCELADO"  then "icons/none.svg"
		when "CONFIRMADO" then "icons/check.svg"
		else "clock.svg"
		end

		image_tag icon, class: "thickIcon", style: "width: 1em; height: 1em;"
	end

	def set_index_title
		current_user.admin? ? "Reservas" : "Minhas reservas"
	end
end
