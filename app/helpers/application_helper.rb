module ApplicationHelper
  def sort_product(column, title = nil)
    title ||= column.titleize #titleizeは先頭の文字を大文字にする
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sort_column
    Products.column_names.include?(params[:sort]) ? params[:sort] : "occurred_date"
  end
end
