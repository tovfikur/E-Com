from rest_framework import viewsets
from ..models import (
    Customer, CustomerPreference, CustomerTag, CustomerNote, Lead,
    Opportunity, Interaction, Task, Segment, Survey, Integration,
    NPSResponse, LifecycleStage, CalendarEvent, Document
)
from .serializers import (
    CustomerSerializer, CustomerPreferenceSerializer, CustomerTagSerializer,
    CustomerNoteSerializer, LeadSerializer, OpportunitySerializer,
    InteractionSerializer, TaskSerializer, SegmentSerializer, SurveySerializer,
    IntegrationSerializer, NPSResponseSerializer, LifecycleStageSerializer,
    CalendarEventSerializer, DocumentSerializer
)

class CustomerViewSet(viewsets.ModelViewSet):
    queryset = Customer.objects.all()
    serializer_class = CustomerSerializer

class CustomerPreferenceViewSet(viewsets.ModelViewSet):
    queryset = CustomerPreference.objects.all()
    serializer_class = CustomerPreferenceSerializer

class CustomerTagViewSet(viewsets.ModelViewSet):
    queryset = CustomerTag.objects.all()
    serializer_class = CustomerTagSerializer

class CustomerNoteViewSet(viewsets.ModelViewSet):
    queryset = CustomerNote.objects.all()
    serializer_class = CustomerNoteSerializer

class LeadViewSet(viewsets.ModelViewSet):
    queryset = Lead.objects.all()
    serializer_class = LeadSerializer

class OpportunityViewSet(viewsets.ModelViewSet):
    queryset = Opportunity.objects.all()
    serializer_class = OpportunitySerializer

class InteractionViewSet(viewsets.ModelViewSet):
    queryset = Interaction.objects.all()
    serializer_class = InteractionSerializer

class TaskViewSet(viewsets.ModelViewSet):
    queryset = Task.objects.all()
    serializer_class = TaskSerializer

class SegmentViewSet(viewsets.ModelViewSet):
    queryset = Segment.objects.all()
    serializer_class = SegmentSerializer

class SurveyViewSet(viewsets.ModelViewSet):
    queryset = Survey.objects.all()
    serializer_class = SurveySerializer

class IntegrationViewSet(viewsets.ModelViewSet):
    queryset = Integration.objects.all()
    serializer_class = IntegrationSerializer

class NPSResponseViewSet(viewsets.ModelViewSet):
    queryset = NPSResponse.objects.all()
    serializer_class = NPSResponseSerializer

class LifecycleStageViewSet(viewsets.ModelViewSet):
    queryset = LifecycleStage.objects.all()
    serializer_class = LifecycleStageSerializer

class CalendarEventViewSet(viewsets.ModelViewSet):
    queryset = CalendarEvent.objects.all()
    serializer_class = CalendarEventSerializer

class DocumentViewSet(viewsets.ModelViewSet):
    queryset = Document.objects.all()
    serializer_class = DocumentSerializer
