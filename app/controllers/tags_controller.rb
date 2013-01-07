class TagsController < ApplicationController
  def remove
    @ticket = Ticket.find(params[:ticket_id])
    
    if can?(:tag, @ticket.project) || current_user.admin?
      @tag = Tag.find(params[:id])
      
      # строка разрывает связь между таблицами ( удаляет соединение ) !!!
      @ticket.tags -= [@tag]

      respond_to do |format|
        @ticket.save
        # ?? зачем тут рендер, почему не респонд то ?
        # render :nothing => true
        format.js
      end
    end
  end
end
