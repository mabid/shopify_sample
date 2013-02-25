module ApplicationHelper
  def is_current(product, value)
    if product.metafields.find(namespace: "testapp", key: "tax_class").present? && product.metafields.find(namespace: "testapp", key: "tax_class").first.value == value
      "selected"
    else
      nil
    end
  end

  def my_render_select(product)
    metafield = product.metafields.find{|mf| mf.namespace = "testapp" }
    html = ""
    ["A", "B", "C"].each do |opt|
      if metafield && metafield.value == opt
        html << "<option selected='selected' value='#{opt}'>#{opt}</option>"
      else
        html<< "<option value='#{opt}'>#{opt}</option>"
      end
    end
    html
    puts "-----------------"
    puts html.inspect
    html
  end
end
