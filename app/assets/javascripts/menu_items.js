var MenuItemsSelect = {
  get_menu_items: function () {
    var menu_id = $(this).val();  // the menu_id is the value of the selected item
    var order_item_id = /\d+/.exec($(this).attr('name'))[0];
    var action_url = '/menu_items/show/' + order_item_id + '/' + menu_id;
    $.ajax({type: 'GET',
            url: action_url,
            timeout: 5000,
            error: function (xhrObj, status, exception) {alert('Server Response Timeout!');},
            success: function (data, status, xhrObject){
              var ele = '#order_order_items_attributes_' + order_item_id + '_menu_item_id';
              $(ele).html(data);
              }
            });
    return(true);
  },
  setup: function () {
    // Initialize the menu_items for each 'Add Item' (order_item) selection.  
    // Without this init function, a reload of the page (due to model validation failure, 
    // for example) will result in the correct menu appearing (that is, the menu selected before 
    // submitting the form) but the incorrect menu_items list will appear - 
    // that list will be the same as the initial menu_items selection list that
    // appeared when the form was first presented.
      
    // Also note that this work-around results in the top-most menu_item being selected upon
    // page reload.   The user will have to reselect another menu_item in the list if desired.
    $('[id^=order_order_items_attributes_][id$=_menu_id]').each(MenuItemsSelect.get_menu_items);
    
    // Add change event callback to each order_item on the page.
    // Note that this is added to the page 'body' but delegated to descendants - this is because
    // descendents (order_item added via 'Add Item' button) can be added after 
    // the initial load of the page.
    $('body').on('change', '[id^=order_order_items_attributes_][id$=_menu_id]', MenuItemsSelect.get_menu_items);
  }
};

$(MenuItemsSelect.setup);