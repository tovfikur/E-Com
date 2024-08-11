from rest_framework import viewsets
from ..models import ( LiveChatSession, ChatHistory, AgentAvailability, SupportTicket, FAQ,
KnowledgeBaseArticle, CustomerFeedback, Escalation, SupportAnalytics, SupportAvailability,
SupportLanguage, SupportResource, AgentPerformance, SupportIntegration )

from .serializers import (LiveChatSessionSerializer, ChatHistorySerializer,
                          AgentAvailabilitySerializer, SupportTicketSerializer,
                          FAQSerializer, KnowledgeBaseArticleSerializer,
                          CustomerFeedbackSerializer, EscalationSerializer,
                          SupportAnalyticsSerializer, SupportAvailabilitySerializer,
                          SupportLanguageSerializer, SupportResourceSerializer,
                          AgentPerformanceSerializer, SupportIntegrationSerializer)

# Define viewsets for each model
class LiveChatSessionViewSet(viewsets.ModelViewSet):
    queryset = LiveChatSession.objects.all()
    serializer_class = LiveChatSessionSerializer

class ChatHistoryViewSet(viewsets.ModelViewSet):
    queryset = ChatHistory.objects.all()
    serializer_class = ChatHistorySerializer

class AgentAvailabilityViewSet(viewsets.ModelViewSet):
    queryset = AgentAvailability.objects.all()
    serializer_class = AgentAvailabilitySerializer

class SupportTicketViewSet(viewsets.ModelViewSet):
    queryset = SupportTicket.objects.all()
    serializer_class = SupportTicketSerializer

class FAQViewSet(viewsets.ModelViewSet):
    queryset = FAQ.objects.all()
    serializer_class = FAQSerializer

class KnowledgeBaseArticleViewSet(viewsets.ModelViewSet):
    queryset = KnowledgeBaseArticle.objects.all()
    serializer_class = KnowledgeBaseArticleSerializer

class CustomerFeedbackViewSet(viewsets.ModelViewSet):
    queryset = CustomerFeedback.objects.all()
    serializer_class = CustomerFeedbackSerializer

class EscalationViewSet(viewsets.ModelViewSet):
    queryset = Escalation.objects.all()
    serializer_class = EscalationSerializer

class SupportAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = SupportAnalytics.objects.all()
    serializer_class = SupportAnalyticsSerializer

class SupportAvailabilityViewSet(viewsets.ModelViewSet):
    queryset = SupportAvailability.objects.all()
    serializer_class = SupportAvailabilitySerializer

class SupportLanguageViewSet(viewsets.ModelViewSet):
    queryset = SupportLanguage.objects.all()
    serializer_class = SupportLanguageSerializer

class SupportResourceViewSet(viewsets.ModelViewSet):
    queryset = SupportResource.objects.all()
    serializer_class = SupportResourceSerializer

class AgentPerformanceViewSet(viewsets.ModelViewSet):
    queryset = AgentPerformance.objects.all()
    serializer_class = AgentPerformanceSerializer

class SupportIntegrationViewSet(viewsets.ModelViewSet):
    queryset = SupportIntegration.objects.all()
    serializer_class = SupportIntegrationSerializer

