---
title: Crews
order: 2
---
{% include ll/init.html %}

{%- assign missions = site.data.ll.missions -%}
{%- assign crewed = '' | split: '' -%}
{%- for m in missions -%}
  {%- assign crew_size = m[1].rocket.spacecraft_stage.launch_crew.size -%}
  {%- if crew_size -%}
    {%- assign crewed = crewed | push: m[1] | sort: 'net' | reverse -%}
    {%- assign total = total | plus: crew_size -%}
  {%- endif -%}
{%- endfor -%}

<table class='crew'>
  <thead>
    <tr>
      <th></th>
      <th>Name</th>
      <th>Age</th>
      <th>Role</th>
      <th>Nationality</th>
    </tr>
  </thead>
  <tbody>
  {% for c in crewed %}
    {%- assign launch_crew = c.rocket.spacecraft_stage.launch_crew -%}
    <tr class="blue">
      <td>{{ crewed.size | minus: forloop.index0 }}</td>
      <td style="text-align: left !important;"><span class="fg-secondary">{{ c.name }}</span></td>
      <td><span class="fg-secondary">{% include widgets/datetime.html datetime=c.net replace=1 %}</span></td>
      <td><code>{{ c.rocket.launcher_stage[0].launcher.serial_number }}</code></td>
      <td><code>{{ c.rocket.spacecraft_stage.spacecraft.serial_number }}</code></td>
    </tr>
    {% for a in launch_crew %}
    <tr class='{{ c.status.abbrev }}'>
      <td>{{ total }}{%- assign total = total | minus: 1 -%}</td>
      <td>{{ a.astronaut.name }}</td>
      <td>{% include widgets/datetime.html datetime=a.astronaut.date_of_birth replace=true %}</td>
      <td>{{ a.role.role }}</td>
      <td title="{{ a.astronaut.agency.name }}">{{ a.astronaut.nationality }}</td>
    </tr>
    {% endfor %}
  {% endfor %}
  </tbody>
</table>