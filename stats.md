---
title: Stats
order: 1
---
{% include ll/init.html %}

{% assign past_launches = site.data.launches | where: "upcoming", "false" | sort: "date_unix" %}
{% assign upcoming = site.data.launches | where: "upcoming", "true" | sort: 'flight_number' %}
{% assign last_launch = past_launches | sort: "flight_number" | last %}

<div markdown=1 class="tables">
<div markdown=1>
{% include ll/missions.html %}

{% include ll/data.html %}

</div>
<div markdown=1>

{% include ll/landings.html %}

{% include ll/landpads.html %}

{% comment %} -------------------- CREWS -------------------- {% endcomment %}
{% assign crewed_launches = past_launches | where_exp: "item", "item.crew.size > 0" %}
| Crews | |
|:---|---:|
| Crewed launches | {% include spx/crewed_launches.html crewed_launches=crewed_launches %} |
| Astronauts | {% include spx/astronauts.html %} |
{: style="min-width:12em;margin-right:1em"}

</div>
<div markdown=1>

{% include ll/launcher.html %}

{% comment %} -------------------- CORE REUSE -------------------- {% endcomment %}
{% assign cores_reuse = site.data.cores | sort: "reuse_count" | group_by: "reuse_count" %}
| Cores reuse | |
|:---|---:|{% for cr in cores_reuse %}
| Reused {{ cr.name }} times | <span title="{% for reused in cr.items %}{{ reused.serial }}&#13;{% endfor %}">{{ cr.items.size }}</span> |{% endfor %}
|----
| Cores reused | {{ site.data.cores | where_exp: "item", "item.reuse_count > 0" | size }} |
{: style="min-width:12em;margin-right:1em"}

</div>
<div markdown=1>
{% comment %} -------------------- YEARS -------------------- {% endcomment %}
{% assign years = past_launches | group_by_exp: "item", "item.date_local | truncate: 4, ''" %}
| Year | &uarr; | Tons |
|:---|---:|---:|
| {{ 'now' | date: "%Y" }} | {{ previous_launches[0].agency_launch_attempt_count_year }} |{% for y in years reversed %}{% assign kg = 0 %}{% for l in y.items %}{% for p in l.payloads %}{% assign payload = site.data.payloads | where: 'id', p %}{% assign kg = kg | plus: payload[0].mass_kg %}{% endfor %}{% endfor %}
| {{ y.name }} | {{ y.items.size }} | {{ kg | divided_by: 907.18474 | round: 1 }} |{% endfor %}
{: style="min-width:12em;margin-right:1em"}
</div>
</div>