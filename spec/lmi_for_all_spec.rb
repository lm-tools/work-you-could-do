require 'rails_helper'
require 'lmi_for_all'

describe LmiForAll do
  let(:lmi_client) do
    double(
      :lmi_client,
      soc_code_lookup: soc_code_details,
      hours_lookup: hours_details,
      pay_lookup: pay_details
    )
  end
  let(:soc_code_details) do
    {
      title: title,
      description: description,
      add_titles: additional_titles,
      tasks: tasks,
      qualifications: qualifications
    }
  end
  let(:hours_details) { double(:hours_details) }
  let(:pay_details) { double(:pay_details) }
  let(:title) { 'Occupation title' }
  let(:description) { 'Occupation description' }
  let(:tasks) { 'Occupation tasks' }
  let(:qualifications) { 'Occupation qualifications' }
  let(:additional_titles) do
    [title_too_short] + [title_with_parenthesis] + [valid_title] * 30
  end
  let(:title_too_short) { 'no' }
  let(:title_with_parenthesis) { 'Occupation (with parenthesis)' }
  let(:valid_title) { 'occupation, with, commas, manager' }
  let(:soc_code) { double(:soc_code) }

  subject(:result) { described_class.new(lmi_client).lookup(soc_code) }

  it 'returns the correct details' do
    expect(result[:soc_code]).to eq(soc_code)
    expect(result[:title]).to eq(title)
    expect(result[:description]).to eq(description)
    expect(result[:tasks]).to eq(tasks)
    expect(result[:qualifications]).to eq(qualifications)
    expect(result[:week_pay]).to eq(pay_details)
    expect(result[:week_hours]).to eq(hours_details)
  end

  it 'returns the first 20 formattable additional titles' do
    expect(result[:additional_titles].split('; ').size).to eq(20)
  end

  it 'does not return additional titles that are shorter than 4 letters' do
    expect(result[:additional_titles].split('; '))
      .not_to include(title_too_short)
  end

  it 'does not return additional titles that have parentheses in them' do
    expect(result[:additional_titles].split('; '))
      .not_to include(title_with_parenthesis)
  end

  it 'reformats additional titles containing commas' do
    expect(result[:additional_titles].split('; '))
      .to include('With, Commas, Manager Occupation')
  end

  context 'occupation title contains n.e.c.' do
    let(:title) { 'Elementary cleaning occupations n.e.c.' }
    let(:description) do
      'Workers in not elsewhere classified in MINOR GROUP 923'
    end
    it 'cleans the title' do
      expect(result[:title]).to eq('Elementary cleaning occupations')
    end
    it 'cleans the description' do
      expect(result[:description]).to eq(
        'Workers in'
      )
    end
  end
end
