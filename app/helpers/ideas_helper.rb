module IdeasHelper
  def potential_stars(potential)
    tag.span("★" * potential + "☆" * (5 - potential), class: "text-sm tracking-wider text-amber-500", title: "Potential: #{potential}/5")
  end

  def status_badge(idea)
    tag.span(idea.status_label, class: "badge badge-#{idea.status}")
  end

  def star_button(idea, extra_class: nil)
    button_to toggle_star_idea_path(idea), method: :patch,
              class: [ "cursor-pointer text-xl leading-none transition hover:scale-110", idea.starred ? "text-amber-500" : "text-stone-300 dark:text-stone-600", extra_class ],
              title: idea.starred ? "Unstar" : "Star", form_class: "inline" do
      idea.starred ? "★" : "☆"
    end
  end

  def nav_link(label, path, icon:, active: false)
    link_to path, class: [ "flex flex-col items-center gap-0.5 rounded-lg px-3 py-1.5 whitespace-nowrap sm:px-4 text-xs font-semibold transition hover:bg-black/5 dark:hover:bg-white/10",
                           active ? "text-ink dark:text-white" : "text-stone-500 dark:text-stone-400" ] do
      safe_join([ nav_icon(icon), label ])
    end
  end

  NAV_ICONS = {
    home: "M3 10.5 12 3l9 7.5V20a1 1 0 0 1-1 1h-5v-6H9v6H4a1 1 0 0 1-1-1z",
    star: "m12 3 2.8 5.7 6.2.9-4.5 4.4 1.1 6.2L12 17.3 6.4 20.2l1.1-6.2L3 9.6l6.2-.9z",
    plus: "M12 5v14M5 12h14"
  }.freeze

  def nav_icon(name)
    tag.svg(tag.path(d: NAV_ICONS.fetch(name)), viewBox: "0 0 24 24", class: "size-5", fill: "none",
            stroke: "currentColor", "stroke-width": 2, "stroke-linecap": "round", "stroke-linejoin": "round", "aria-hidden": true)
  end
end
