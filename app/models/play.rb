class Play < ActiveRecord::Base
  validates :title, presence: true
  validates :xml, presence: true
  validate :valid_xml

  def analyze
    xml_doc = Nokogiri::XML(self.xml) { |config| config.noblanks }
    title = xml_doc.at_xpath('//PLAY//TITLE').children.text
    total_scenes = xml_doc.search('SCENE').size
    total_lines = xml_doc.search('SPEECH').size
    roles = []

    xml_doc.xpath('//PLAY//PERSONAE//PGROUP//PERSONA').children.each do |role|
      line_count = []
      scene_count = 0

      xml_doc.search('SCENE').each do |scene|
        scene.search('SPEECH').each do |speech|
          line_count << speech.search('LINE').first if speech.search('SPEAKER').first.text == role.text
        end

        scene_count += 1 if scene.search('SPEAKER').any? { |name| name.text == role.text }
      end

      longest_speech = line_count.sort_by { |line| line.text.size }

      character = {
        role: role.text,
        lines: line_count.size,
        scenes: scene_count,
        percent_of_scenes: ((scene_count.to_f / total_scenes.to_f) * 100).round(2),
        longest_speech: longest_speech.empty? ? 0 : longest_speech[-1].text.size,
        longest_speech_text: longest_speech.empty? ? "" : longest_speech[-1].text
      }

      roles << character
    end

    roles
  end

  protected
  def valid_xml
    true
  end
end
