module IdeasHelper
  def potential_stars(potential)
    tag.span("★" * potential + "☆" * (5 - potential), class: "tracking-wider text-amber-400", title: "Potential: #{potential}/5")
  end

  def status_badge(idea)
    tag.span(idea.status_label, class: "badge badge-#{idea.status}")
  end

  def star_button(idea)
    button_to toggle_star_idea_path(idea), method: :patch,
              class: [ "cursor-pointer text-xl leading-none transition hover:scale-110", idea.starred ? "text-amber-400" : "text-slate-300 dark:text-slate-600" ],
              title: idea.starred ? "Unstar" : "Star", form_class: "inline" do
      idea.starred ? "★" : "☆"
    end
  end
end
