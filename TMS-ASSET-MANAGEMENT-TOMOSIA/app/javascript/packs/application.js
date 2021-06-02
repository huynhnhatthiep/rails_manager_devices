import "channels"
import "chartkick/chart.js"
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"

require("packs/request")
require('jquery')

Rails.start()
Turbolinks.start()
ActiveStorage.start()
