import 'package:flutter_job_timer_dw/app/core/adapters/json_to_project.dart';
import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_job_timer_dw/app/entities/project_task.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'deve converter um map em um objeto do tipo Project',
    () {
      final order = JsonToProject.fromMap({
        'id': 'aZasdAASDnasdj',
        'name': 'Teste Projeto',
        'estimate': 120,
        'status': 0,
        'tasks': [
          {
            'name': 'Nova task',
            'duration': 12,
          }
        ],
      });

      expect(order, isA<Project>());
      expect(order.id, 'aZasdAASDnasdj');
      expect(order.status, ProjectStatus.em_andamento);
      expect(order.tasks.length, 1);
      expect(order.tasks.first.name, 'Nova task');
      expect(order.tasks.first.duration, 12);
    },
  );

  test('deve converter um objeto do tipo Project em um Map', () {
    final order = Project(
      id: '12345',
      name: 'Projeto Entidade',
      estimate: 20,
      status: ProjectStatus.em_andamento,
      tasks: [ProjectTask(name: 'Task1', duration: 22)],
    );

    final map = JsonToProject.toMap(order);

    expect(map, isA<Map<String, dynamic>>());
    expect(map['id'], '12345');
    expect(map['name'], 'Projeto Entidade');
    expect(map['status'], 0);
    expect(map['tasks'].length, 1);
    expect((map['tasks'] as List).first['name'], 'Task1');
    expect((map['tasks'] as List).first['duration'], 22);
  });
}
