class ErrorController < ApplicationController
  def confirm
    render inline: 'google-site-verification: googleb4007362349b57e0.html'
  end
end