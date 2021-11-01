
$(document).on('turbolinks:load', function(){
  const inputForm = $('#searching-form');
  const searchResult = $('.result ul');

  function builtHTML(data){
    let html = `
    <li><a href="/videos/${data.id}/edit" data-method="get">${data.title}<a></li>
    `
    searchResult.append(html);
  }

  function NoResult(message){
    let html = `
    <li>${message}</li>
    `
    searchResult.append(html);

  }
  inputForm.on('keyup', function(){
    const target = $(this).val();
    search(target);
  });

  function search(target){
    $.ajax({
      type: 'GET',
      url: '/videos/search',
      data: { key_word: target },
      dataType: 'json'
    })

    .done(function(data){
      searchResult.empty();

      if (data.length !== 0){
        data.forEach(function(data){
          builtHTML(data)
        });
      }else{
        NoResult('検索結果がありませんでした')
      }
    })
    .fail(function(data){
      alert("非同期通信が行えませんでした");
    })
  }
});

