# frozen_string_literal: true

# Helpers de ajuda para exibir dados nas viewa
module StringHelper
  include ActionView::Helpers::NumberHelper

  # Formata data ou retorna string vazia caso nao receba uma valor
  def formata_data(data, mascara = '%d/%m/%Y', blank: '-')
    return blank if data.blank?

    data.to_date.strftime(mascara)
  end

  # tranforma Date em mês
  def formata_mes(data)
    I18n.l data, format: '%B'
  end

  # Formata data ou retorna string vazia caso nao receba uma valor
  def formata_data_param(data)
    return if data.blank?

    data.to_date.strftime('%Y-%m-%d')
  rescue StandardError
    nil
  end

  # Formata data ou retorna string vazia caso nao receba uma valor
  def formata_data_hora(data, mascara = '%d/%m/%Y - %H:%Mh', blank: '-')
    return blank if data.blank?

    data.to_time.strftime(mascara)
  end

  # Formata booleano para SIM|NAO
  def formata_boolean(valor)
    case valor
    when 'S', 'T', 'Sim', true, 1
      'Sim'
    else
      'Não'
    end
  end

  # formata valor em percentual
  def formata_percentual(valor, blank: '0,0')
    return blank if valor.blank? || valor.zero?

    number_with_precision(valor, delimiter: '.', separator: ',', precision: 1)
  end

  # formata valor em dinheiro
  def formata_dinheiro(valor, blank: '0,00')
    return blank if valor.blank? || valor.zero?

    number_with_precision(valor, delimiter: '.', separator: ',', precision: 2)
  end

  def formata_dinheiro_extenso(valor)
    BrazilianCardinality::Currency.currency_cardinal(valor.to_f)
  end

  # formata valor em numero
  def formata_numero(valor, blank: '0,00', precision: 2)
    return blank if valor.blank? || valor.zero?

    number_with_precision(valor, separator: '.', precision: precision)
  end

  def mostra(valor)
    return '' unless valor.present?

    valor
  end

  def telefone_sem_mascara(telefone, blank: '')
    return blank if telefone.blank?

    telefone.strip.gsub(/[^a-zA-Z0-9.]/, '')
  end

  def remove_acentos(str)
    return '' if str.blank?

    accents = {
      %w[á à â ä ã] => 'a',
      %w[Ã Ä Â À] => 'A',
      %w[é è ê ë] => 'e',
      %w[Ë É È Ê] => 'E',
      %w[í ì î ï] => 'i',
      %w[Î Ì Í] => 'I',
      %w[ó ò ô ö õ] => 'o',
      %w[Õ Ö Ô Ò Ó] => 'O',
      %w[ú ù û ü] => 'u',
      %w[Ú Û Ù Ü] => 'U',
      ['ç'] => 'c', ['Ç'] => 'C',
      ['ñ'] => 'n', ['Ñ'] => 'N'
    }
    accents.each do |ac, rep|
      ac.each do |s|
        str = str.gsub(s, rep)
      end
    end

    # str = str.gsub(/[^a-zA-Z0-9\. ]/, '')

    str
  end

  def string_to_ascii(str)
    text = remove_acentos(str.to_s)
    text.encode('ASCII', 'UTF-8', invalid: :replace, undef: :replace, replace: '')
  end

  def conta_texto_linhas(text, blank_value = 0)
    return blank_value if text.blank?

    text.split("\n").size + 1
  end

  def pluralize_contator(number, singular, plural)
    return "#{number} #{singular}" if number >= 1 && number < 2

    "#{number} #{plural}"
  end
end
