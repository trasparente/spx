---
title: Files
order: 3
---
<table class="border">
  <tbody data-sort="up">
    {% for m in site.data.ll.missions %}<tr class="{{ m[1].status.abbrev }}" sort="{{ m[1].window_start }}">
      <td><code>{{ m[1].launch_service_provider.total_launch_count }}</code></td>
      <td>{{ m[1].mission.name }}</td>
      <td><code>{% assign year_window = m[1].window_start %}{{ year_window | replace: "T", " " | replace: "Z", " " }}</code></td>
      <td>{% include widgets/datetime.html datetime=year_window replace=true %}</td>
    </tr>{% endfor %}
  </tbody>
</table>
