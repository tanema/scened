class Script < Shoes::Stack
  attr_accessor :list_view, :script_view

  def add_character
    list.app do
      list.append do
        para "test"
      end
    end
  end

  def add_dialogue
  end

  def add_question
  end

  def open
   filename = ask_open_file
   Shoes.app do
     File.read(filename)
   end
  end

  def save
    unless @file 
      save_as = ask_save_file 
    end
  end

end
