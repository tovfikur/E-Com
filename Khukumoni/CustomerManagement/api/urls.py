from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    CustomerViewSet, CustomerPreferenceViewSet, CustomerTagViewSet, CustomerNoteViewSet,
    LeadViewSet, OpportunityViewSet, InteractionViewSet, TaskViewSet, SegmentViewSet,
    SurveyViewSet, IntegrationViewSet, NPSResponseViewSet, LifecycleStageViewSet,
    CalendarEventViewSet, DocumentViewSet
)

router = DefaultRouter()
router.register(r'customers', CustomerViewSet)
router.register(r'preferences', CustomerPreferenceViewSet)
router.register(r'tags', CustomerTagViewSet)
router.register(r'notes', CustomerNoteViewSet)
router.register(r'leads', LeadViewSet)
router.register(r'opportunities', OpportunityViewSet)
router.register(r'interactions', InteractionViewSet)
router.register(r'tasks', TaskViewSet)
router.register(r'segments', SegmentViewSet)
router.register(r'surveys', SurveyViewSet)
router.register(r'integrations', IntegrationViewSet)
router.register(r'nps_responses', NPSResponseViewSet)
router.register(r'lifecycle_stages', LifecycleStageViewSet)
router.register(r'calendar_events', CalendarEventViewSet)
router.register(r'documents', DocumentViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
