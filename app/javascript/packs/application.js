document.addEventListener('DOMContentLoaded', function() {
  const eventTypeSelect = document.getElementById('budget_event_type_id');
  const decorationSelect = document.getElementById('budget_decoration_id');
  
  eventTypeSelect.addEventListener('change', function() {
    const eventTypeId = eventTypeSelect.value;
    
    if (eventTypeId) {
      fetch(`/decorations/by_event_type_id/${eventTypeId}`)
        .then(response => response.json())
        .then(data => {
          decorationSelect.innerHTML = '<option value="">Nenhuma</option>';
          
          data.forEach(function(decoration) {
            const option = document.createElement('option');
            option.value = decoration.id;
            option.textContent = decoration.name;
            decorationSelect.appendChild(option);
          });
        });
    } else {
      decorationSelect.innerHTML = '<option value="">Selecione a decoração</option>';
    }
  });
});