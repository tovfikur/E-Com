from rest_framework import serializers
from ..models import ( LiveChatSession, ChatHistory, AgentAvailability, SupportTicket, FAQ,
KnowledgeBaseArticle, CustomerFeedback, Escalation, SupportAnalytics, SupportAvailability,
SupportLanguage, SupportResource, AgentPerformance, SupportIntegration )

class LiveChatSessionSerializer(serializers.ModelSerializer):
    class Meta:
        model = LiveChatSession
        fields = '__all__'

class ChatHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = ChatHistory
        fields = '__all__'

class AgentAvailabilitySerializer(serializers.ModelSerializer):
    class Meta:
        model = AgentAvailability
        fields = '__all__'

class SupportTicketSerializer(serializers.ModelSerializer):
    class Meta:
        model = SupportTicket
        fields = '__all__'

class FAQSerializer(serializers.ModelSerializer):
    class Meta:
        model = FAQ
        fields = '__all__'

class KnowledgeBaseArticleSerializer(serializers.ModelSerializer):
    class Meta:
        model = KnowledgeBaseArticle
        fields = '__all__'

class CustomerFeedbackSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomerFeedback
        fields = '__all__'

class EscalationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Escalation
        fields = '__all__'

class SupportAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = SupportAnalytics
        fields = '__all__'

class SupportAvailabilitySerializer(serializers.ModelSerializer):
    class Meta:
        model = SupportAvailability
        fields = '__all__'

class SupportLanguageSerializer(serializers.ModelSerializer):
    class Meta:
        model = SupportLanguage
        fields = '__all__'

class SupportResourceSerializer(serializers.ModelSerializer):
    class Meta:
        model = SupportResource
        fields = '__all__'

class AgentPerformanceSerializer(serializers.ModelSerializer):
    class Meta:
        model = AgentPerformance
        fields = '__all__'

class SupportIntegrationSerializer(serializers.ModelSerializer):
    class Meta:
        model = SupportIntegration
        fields = '__all__'

