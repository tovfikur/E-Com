#!/bin/bash

APP_NAME="CustomerSupport"
PROJECT_NAME="Khukumoni"
API_DIR="../$PROJECT_NAME/$APP_NAME/api"
VIEWS_FILE="$API_DIR/views.py"
URLS_FILE="$API_DIR/urls.py"
SERIALIZERS_FILE="$API_DIR/serializers.py"
SETTINGS_FILE="../$PROJECT_NAME/$PROJECT_NAME/settings.py"
PROJECT_URLS_FILE="../$PROJECT_NAME/$PROJECT_NAME/urls.py"
APP_URLS_FILE="../$PROJECT_NAME/$APP_NAME/urls.py"

# Step 1: Create the api folder and files
mkdir -p $API_DIR
touch $API_DIR/__init__.py

# Step 2: Create serializers.py
cat <<EOF > $SERIALIZERS_FILE
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

EOF

# Step 3: Create views.py
cat <<EOF > $VIEWS_FILE
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

EOF

# Step 4: Create urls.py
cat <<EOF > $URLS_FILE
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import *

router = DefaultRouter()

# Register viewsets for each model

urlpatterns = [
    path('', include(router.urls)),
]
EOF

# Step 5: Ensure the main project urls.py file exists and include the api urls
if [ ! -f "$APP_URLS_FILE" ]; then
    # Create the main urls.py if it does not exist
    cat <<EOF > $APP_URLS_FILE
from django.urls import path, include

urlpatterns = [
    path('api/', include('$APP_NAME.api.urls')),
]
EOF
else
    # Add the api path if it's not already included
    if ! grep -q "path('api/', include('$APP_NAME.api.urls'))" "$APP_URLS_FILE"; then
        sed -i "/urlpatterns = \[/a \ \ \ \ path('api/', include('$APP_NAME.api.urls'))," $APP_URLS_FILE
    fi
fi

# Step 6: Add the app path to the main project urls.py if not already included
if ! grep -q "path('$APP_NAME/', include('$APP_NAME.urls'))" "$PROJECT_URLS_FILE"; then
    sed -i "/urlpatterns = \[/a \ \ \ \ path('$APP_NAME/', include('$APP_NAME.urls'))," $PROJECT_URLS_FILE
fi

# Display success message
echo "CustomerSupport app created with models and registered in Django admin."
