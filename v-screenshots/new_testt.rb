context 'when the link parameter "cv" exists' do
  let(:solr_document_with_cv) do
    SolrDocument.new(id: 'abc123',
      iiif_manifest_url_ssi: 'https://manifest.store/ark%3A%2Fabc%2F123/manifest',
      member_ids_ssim: 7)
  end

  it 'links to the corresponding Work page in the universal viewer' do
    allow(request).to receive(:query_parameters).and_return('cv' => 7)

    expect(service.src(request, solr_document_with_cv)).to eq 'http://test.url/uv/uv.html#?cv=7&manifest=https%3A%2F%2Fmanifest.store%2Fark%253A%252Fabc%252F123%2Fmanifest'
  end

  it 'returns page 1 if someone requests a page higher than the total page count' do
    allow(request).to receive(:query_parameters).and_return('cv' => 9)

    expect(service.src(request, solr_document_with_cv)).to eq 'http://test.url/uv/uv.html#?manifest=https%3A%2F%2Fmanifest.store%2Fark%253A%252Fabc%252F123%2Fmanifest'
  end
end