---
title: Files
order: 3
---
{%- assign saved = site.data.ll.missions.size -%}
{%- assign total = site.data.ll.agency.total_launch_count -%}
{%- assign saved_pct = 100.0 | divided_by: total | times: saved | append: "%" -%}
{% include widgets/bar.html titles="Saved" widths=saved_pct labels=saved %}
<table class="border">
  <tbody data-sort="desc">
    {% for m in site.data.ll.missions %}<tr class="{{ m[1].status.abbrev }}" sort="{{ m[1].window_start }}">
      <td title="{{ m[1].id }}"><code>{{ m[1].orbital_launch_attempt_count }}</code></td>
      <td>{{ m[1].mission.name }}</td>
      <td><code>{% assign year_window = m[1].window_start %}{{ year_window | replace: "T", " " | replace: "Z", " " }}</code></td>
      <td>{% include widgets/datetime.html datetime=year_window replace=true %}</td>
      <td>{% assign crew_size = m[1].rocket.spacecraft_stage.launch_crew.size %}{% if crew_size %}Crew ({{ crew_size }}){%- endif -%}</td>
      <td>{% for s in m[1].rocket.launcher_stage %}{{ s.launcher.serial_number | replace: "Unknown", "" | replace: "F9", "" }}{% unless forloop.last %}<br>{% endunless %}{% endfor %}</td>
      <td>{% for s in m[1].rocket.launcher_stage %}{{ s.landing.location.abbrev | replace: "N/A", "" }}{% unless forloop.last %}<br>{% endunless %}{% endfor %}</td>
    </tr>{% endfor %}
  </tbody>
</table>
