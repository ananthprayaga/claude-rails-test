module IdeasHelper
  POTENTIAL_LABELS = { 1 => "Long shot", 2 => "Modest", 3 => "Promising", 4 => "Strong", 5 => "Huge" }.freeze

  def potential_options
    POTENTIAL_LABELS.map { |n, label| [ "#{n} – #{label}", n ] }
  end

  def potential_stars(potential)
    stars = (1..5).map do |n|
      icon(:star, class: [ "size-4", n <= potential ? "text-amber-500" : "text-stone-300 dark:text-stone-600" ], filled: n <= potential)
    end
    tag.span(safe_join(stars), class: "inline-flex items-center gap-0.5", role: "img",
             "aria-label": "Potential: #{potential} of 5", title: "Potential: #{POTENTIAL_LABELS[potential]} (#{potential}/5)")
  end

  def status_badge(idea)
    tag.span(idea.status_label, class: "badge badge-#{idea.status}")
  end

  # Icon-only on cards (a star is universally understood); labelled on the idea page.
  def star_button(idea, labelled: false, extra_class: nil)
    label = idea.starred ? "Starred" : "Star"
    button_to toggle_star_idea_path(idea), method: :patch, form_class: "inline", title: idea.starred ? "Remove star" : "Star this idea",
              "aria-label": idea.starred ? "Remove star" : "Star this idea", "aria-pressed": idea.starred,
              class: [ labelled ? "btn btn-quiet" : "cursor-pointer rounded-full p-1 transition hover:bg-black/5 dark:hover:bg-white/10",
                       idea.starred ? "text-amber-600 dark:text-amber-400" : "text-stone-500", extra_class ] do
      safe_join([ icon(:star, filled: idea.starred), (label if labelled) ])
    end
  end

  def nav_link(label, path, icon:, active: false)
    link_to path, "aria-current": (active ? "page" : nil),
                  class: [ "flex flex-col items-center gap-1 rounded-lg px-4 py-1 text-sm font-semibold whitespace-nowrap transition hover:bg-black/5 dark:hover:bg-white/10",
                           active ? "text-ink dark:text-white" : "text-stone-600 dark:text-stone-400" ] do
      safe_join([ icon(icon, class: "size-6"), label ])
    end
  end
end
