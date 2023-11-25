function profile::pretty_print($data) {
  return inline_template("
<%- require 'json' -%>
<%= JSON.pretty_generate(@data) %>
")
}
