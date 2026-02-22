import 'package:matger_core_logic/core/orgnization/data/organization_model.dart';
import 'package:matger_core_logic/core/orgnization/source/organization_source.dart';
import 'package:JoDija_reposatory/utilis/models/remote_base_model.dart';
import 'package:JoDija_reposatory/utilis/models/staus_model.dart';

class OrganizationRepo {
  late final OrganizationSource _organizationSource;

  OrganizationRepo({OrganizationSource? organizationSource}) {
    _organizationSource = organizationSource ?? OrganizationSource();
  }

  Future<RemoteBaseModel<OrganizationData>> createOrganizationWithOwner({
    required Map<String, dynamic> userData,
    required OrganizationData organizationData,
  }) async {
    final result = await _organizationSource.createOrganizationWithOwner(
      userData: userData,
      organizationData: organizationData.toJson(),
    );

    if (result.error != null) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: result.error?.message,
      );
    }

    try {
      // Assuming the response returns the created organization in a field or directly
      final data = result.data['organization'] ?? result.data;
      return RemoteBaseModel(
        data: OrganizationData.fromJson(data as Map<String, dynamic>),
        status: StatusModel.success,
      );
    } catch (e) {
      return RemoteBaseModel(
        status: StatusModel.error,
        message: "Parsing Error: $e",
      );
    }
  }
}
