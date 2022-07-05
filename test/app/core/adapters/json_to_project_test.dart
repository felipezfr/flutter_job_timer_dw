import 'package:flutter_job_timer_dw/app/core/adapters/json_to_project.dart';
import 'package:flutter_job_timer_dw/app/entities/project_entity.dart';
import 'package:flutter_job_timer_dw/app/entities/project_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'deve converter um map em um objeto do tipo ProjectEntity',
    () {
      final order = JsonToProject.fromMap({
        'id': 'aZasdAASDnasdj',
        'name': 'Teste Projeto',
        'estimate': 120,
        'status': 0,
        // 'status': 'em_andamento',
        'tasks': [
          {
            'name': 'Nova task',
            'duration': 12,
          }
        ],
      });

      expect(order, isA<ProjectEntity>());
      expect(order.status, ProjectStatus.em_andamento);
    },
  );

  test('deve converter um objeto do tipo ProjectEntity em um Map', () {
    final order = ProjectEntity(
      id: '12345',
      name: 'Projeto Entidade',
      estimate: 20,
      status: ProjectStatus.em_andamento,
      tasks: [],
    );

    final map = JsonToProject.toMap(order);

    expect(map, isA<Map<String, dynamic>>());
    expect(map['id'], '12345');
    expect(map['name'], 'Projeto Entidade');
    expect(map['status'], 'em_andamento');
  });
}
