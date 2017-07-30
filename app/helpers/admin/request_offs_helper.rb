module Admin::RequestOffsHelper
	def status_css_color(status)
		case status
		when 'canceled'
			'alert-warning'
		when 'rejected'
			'alert-danger'
		when 'accepted'
			'alert-success'
		else
			'alert-info'
		end
	end

	def status_css_color_panel(status)
		case status
		when 'canceled'
			'panel-yellow'
		when 'rejected'
			'panel-red'
		when 'accepted'
			'panel-green'
		else
			'panel-primary'
		end
	end
end
