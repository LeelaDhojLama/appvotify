import 'package:get_it/get_it.dart';
import 'package:vote/core/services/CountryAPI.dart';
import 'package:vote/core/services/UserApi.dart';
import 'package:vote/core/services/PartyApi.dart';
import 'package:vote/core/services/API.dart';
import 'package:vote/core/services/VoteApi.dart';
import 'package:vote/core/services/CandidateApi.dart';
import 'core/viewmodels/UserViewModel.dart';
import 'core/viewmodels/CountryViewModel.dart';
import 'core/viewmodels/PartyViewModel.dart';
import 'core/viewmodels/VoteViewModel.dart';
import 'core/viewmodels/CandidateViewModel.dart';


GetIt locater = GetIt.instance;

void setupLocator(){

  locater.registerLazySingleton<UserApi>(()=>UserApi('user'));
  locater.registerLazySingleton(()=>CountryApi('country'));
  locater.registerLazySingleton(()=>PartyApi('party'));
  locater.registerLazySingleton(()=>VoteApi('vote'));
  locater.registerLazySingleton(()=>CandidateApi('candidate'));
  locater.registerLazySingleton(()=>Api('db'));
  locater.registerSingleton(UserViewModel());
  locater.registerSingleton(PartyViewModel());
  locater.registerSingleton(CandidateViewModel());
  locater.registerSingleton(VoteViewModel());

  locater.registerSingleton(CountryViewModel());
}