import 'package:flutter/material.dart';
import 'package:todo_list_provider/shared/extensions/date_extension.dart';

import '../../../shared/inputs/text_input_widget.dart';

class DateTextInputWidget extends StatelessWidget {
  final TextEditingController todoDateTEC;
  final FocusNode todoDateFN;
  final void Function() addTodo;
  final void Function(DateTime date) setDate;

  const DateTextInputWidget({
    required this.todoDateTEC,
    required this.todoDateFN,
    required this.addTodo,
    required this.setDate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextInputWidget(
      controller: todoDateTEC,
      focusNode: todoDateFN,
      validator: (String? newTodoDate) {
        if (newTodoDate == null || newTodoDate.isEmpty) {
          return 'Você precisa adicionar uma data';
        }
        return null;
      },
      label: 'Data',
      onFieldSubmitted: (_) => addTodo(),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          cancelText: 'Cancelar',
          confirmText: 'Confirmar',
          helpText: 'Selecione a data da Tarefa',
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(
            const Duration(days: 100 * 365),
          ),
        );

        String stringDate = '';

        if (date != null) {
          setDate(date);
          stringDate = date.formatDate;
        }

        todoDateTEC.text = stringDate;

        todoDateFN.unfocus();
      },
      readOnly: true,
    );
  }
}
