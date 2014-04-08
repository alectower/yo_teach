class StandardsImport
  attr_accessor :dir

  def initialize(dir)
    raise "Must provide directory" unless dir
    @dir = File.expand_path dir
  end

  def import
    store_info "#{dir}/ela-literacy.xml"
    store_info "#{dir}/math.xml"
  end

  private

  def store_info(file)
    contents = IO.read(File.absolute_path file)
    data = Hash.from_xml(contents)
    data["LearningStandards"].each do |items|
      items[1].each do |item|
        dot = item['StatementCodes']['StatementCode']
        if dot
          create_standard(item)
        end
      end
    end
  end

  def create_standard(item)
    dot = item['StatementCodes']['StatementCode']
    code = dot.split('.')
    type = code[1]
    abort "Uknown type #{type}" if !valid_type(type)
    CoreStandard.create standard_type: type,
      dot_notation: dot,
      uri: item['RefURI'],
      guid: item['RefID'],
      description: item['Statements']['Statement']
  end

  def valid_type(type)
    ['Math', 'ELA-Literacy'].include? type
  end

end
