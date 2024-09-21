lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 34.38886886886887 --fixed-mass2 42.79327327327328 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1018208493.9857228 \
--gps-end-time 1018215693.9857228 \
--d-distr volume \
--min-distance 1898.9027922489952e3 --max-distance 1898.9227922489952e3 \
--l-distr fixed --longitude 89.59101867675781 --latitude 6.252725601196289 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
