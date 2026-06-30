import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import '../models/profile_model.dart';
import '../models/skill_model.dart';
import '../models/portfolio_link.dart';
import '../repositories/profile_repository.dart';

final profileProvider = AsyncNotifierProvider<ProfileNotifier, ProfileModel>(() {
  return ProfileNotifier();
});

class ProfileNotifier extends AsyncNotifier<ProfileModel> {
  late ProfileRepository _repository;

  @override
  Future<ProfileModel> build() async {
    _repository = ref.watch(profileRepositoryProvider);
    return _fetchProfile();
  }

  Future<ProfileModel> _fetchProfile() async {
    return await _repository.getProfile();
  }

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? headline,
    String? bio,
  }) async {
    if (state.value == null) return;
    
    // Optimistic UI Update
    final current = state.value!;
    final updated = current.copyWith(
      firstName: firstName ?? current.firstName,
      lastName: lastName ?? current.lastName,
      headline: headline ?? current.headline,
      bio: bio ?? current.bio,
    );
    
    state = AsyncData(updated);

    try {
      await _repository.updateProfile(updated);
    } catch (e, st) {
      state = AsyncError(e, st);
      // Revert on error
      state = AsyncData(current);
    }
  }

  Future<void> addSkill(String skillName) async {
    if (state.value == null) return;
    final current = state.value!;
    final newSkill = SkillModel(id: DateTime.now().millisecondsSinceEpoch, name: skillName);
    
    final updatedSkills = List<SkillModel>.from(current.skills)..add(newSkill);
    final updated = current.copyWith(skills: updatedSkills);
    
    state = AsyncData(updated);
    // call repository.updateProfile(updated) in real app
  }

  Future<void> removeSkill(int skillId) async {
    if (state.value == null) return;
    final current = state.value!;
    
    final updatedSkills = current.skills.where((s) => s.id != skillId).toList();
    final updated = current.copyWith(skills: updatedSkills);
    
    state = AsyncData(updated);
    // call repository.updateProfile(updated) in real app
  }
  
  Future<void> addPortfolioLink(String title, String url) async {
    if (state.value == null) return;
    final current = state.value!;
    final newLink = PortfolioLink(id: DateTime.now().millisecondsSinceEpoch, title: title, url: url);
    
    final updatedLinks = List<PortfolioLink>.from(current.portfolioLinks)..add(newLink);
    final updated = current.copyWith(portfolioLinks: updatedLinks);
    
    state = AsyncData(updated);
  }

  Future<void> removePortfolioLink(int linkId) async {
    if (state.value == null) return;
    final current = state.value!;
    
    final updatedLinks = current.portfolioLinks.where((l) => l.id != linkId).toList();
    final updated = current.copyWith(portfolioLinks: updatedLinks);
    
    state = AsyncData(updated);
  }

  Future<bool> uploadAvatar(XFile file) async {
    if (state.value == null) return false;
    final current = state.value!;
    
    try {
      final newUrl = await _repository.uploadAvatar(file);
      state = AsyncData(current.copyWith(avatarUrl: newUrl));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> uploadResume(PlatformFile file) async {
    if (state.value == null) return false;
    final current = state.value!;
    
    try {
      final newUrl = await _repository.uploadResume(file);
      state = AsyncData(current.copyWith(resumeUrl: newUrl));
      return true;
    } catch (e) {
      return false;
    }
  }
}
