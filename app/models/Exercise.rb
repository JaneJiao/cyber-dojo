
class Exercise

  def initialize(path,name,disk)
    @path,@name = path,name
    @disk = disk
  end

  attr_reader :name

  def new_name
    # Some exercises/ sub-folders have been renamed.
    # This creates a problem for the script
    # admin_scripts/convert_katas_format.rb
    # See app/models/Kata.rb ::exercise()
    # See app/models/Kata.rb ::original_exercise()
    renames = {
      'Yahtzee' => 'Yatzy',
      'Yahtzee_Cutdown' => 'Yatzy_Cutdown'
    }
    renames[name] || name
  end

  def path
    @path + name + '/'
  end

  def dir
    @disk[path]
  end

  def exists?
    dir.exists?(instructions_filename)
  end

  def instructions
    raw = dir.read(instructions_filename)
    raw.force_encoding('UTF-8')
    raw.encode('UTF-8', 'binary', :invalid => :replace, :undef => :replace, :replace => '')
  end

  def instructions_filename
    'instructions'
  end

end
